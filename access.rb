# This script compares the efficiency of different ways of finding and calling a method in a class

COMMAND_COUNT = 500
COMMAND_CALLS = 2000000
ITERATIONS = 10

$command_sequence = nil
$instance = nil
$results = {
    switch: 0,
    string: 0,
    binding: 0,
    lambda: 0
}

class Test
    attr_accessor :code
    @@command_map = nil
    @@commands = nil

    def string_operation()
        sym = "command_#{@code}".to_sym
        method(sym).call() if respond_to?(sym)
    end

    def binding()
        @@command_map[@code]&.bind(self).call()
    end

    def lambda()
        instance_exec(&@@commands[@code])
    end
end

def build_class()
    str = "class Test;"

    arr = (1..COMMAND_COUNT).to_a
    arr.each do |i|
       str += "def command_#{i}(); return @code; end;" # Make sure there's an operation in there so it's not optimized out
    end

    str += "def switch(); case @code;"
    arr.each do |i|
        str += "when #{i}; return command_#{i}();"
    end
    str += "else; return true; end; end;"

    str += "def setup_command_map(); return unless @@command_map.nil?; commands = ["
    arr.each do |i|
        str += "#{i},"
    end
    str += "]; @@command_map = {}; commands.each do |code|; @@command_map[code] = self.class.instance_method(\"command_\" + code.to_s); end; end;"

    str += "def setup_commands(); return unless @@commands.nil?; @@commands = {};"
    arr.each do |i|
        str += "@@commands[#{i}] = ->() { return @code };"
    end
    str += "end;"

    str += "end;"

    eval(str)
    $instance = Test.new()
    $instance.setup_command_map()
    $instance.setup_commands()
end

def generate_command_sequence()
    $command_sequence = nil
    GC.start()
    $command_sequence = Array.new(COMMAND_CALLS)

    COMMAND_CALLS.times do |i|
        $command_sequence[i] = rand(COMMAND_COUNT) + 1
    end

    return $command_sequence
end

def switch_time()
    i, len = 0, $command_sequence.length
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    while i < len
        $instance.code = $command_sequence[i]
        $instance.switch()
        i += 1
    end
    finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    $results[:switch] += finish - start
end

def string_operation_time()
    i, len = 0, $command_sequence.length
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    while i < len
        $instance.code = $command_sequence[i]
        $instance.string_operation()
        i += 1
    end
    finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    $results[:string] += finish - start
end

def binding_time()
    i, len = 0, $command_sequence.length
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    while i < len
        $instance.code = $command_sequence[i]
        $instance.binding()
        i += 1
    end
    finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    $results[:binding] += finish - start
end

def lambda_time()
    i, len = 0, $command_sequence.length
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    while i < len
        $instance.code = $command_sequence[i]
        $instance.lambda()
        i += 1
    end
    finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    $results[:lambda] += finish - start
end

begin
    puts "> Building class..."
    build_class()

    i = 0
    while i < ITERATIONS
        puts nil, ">\t\t Iteration: #{i}"

        puts "> Generating command call sequence..."
        generate_command_sequence()

        puts "> Measuring switch case time..."
        switch_time()

        puts "> Measuring string operation time..."
        string_operation_time()

        puts "> Measuring binding time..."
        binding_time()

        puts "> Measuring lambda time..."
        lambda_time()

        i += 1
    end
	
    puts nil, "> Results for #{ITERATIONS} iterations of #{COMMAND_COUNT} commands with #{COMMAND_CALLS} calls:"
    puts "Command"
    $results.each do |k, v|
        puts "#{k.to_s}\t: #{v}"
    end
rescue => err
    puts err
end
gets
# Compare access to different scopes

module Module_Method
	def self.action()
		return 1 + 1
	end
end

class Singleton_Method
	def action()
		return 1 + 1
	end
end
$singleton = Singleton_Method.new()

def global_method()
	return 1 + 1
end

DEFAULT_COUNT = 1000000000
count = DEFAULT_COUNT

i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	Module_Method.action()
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Module\t: #{delta}"

i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	$singleton.action()
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Singleton\t: #{delta}"

i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	global_method()
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Global\t: #{delta}"


puts nil, "> Jobs done!"
gets
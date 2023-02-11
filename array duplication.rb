
# Dummy class to make an operation in
class Dummy; def call(); return 1 + 1; end; end;

LEN = 100000000

$arr1 = Array.new(LEN)
$arr2 = []

i = 0
while i < LEN
	$arr1[i] = Dummy.new()
	$arr2.push(Dummy.new())
	i += 1
end

$arr3 = []

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$arr1.each do |d| d.call(); end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Array 1: #{delta}"

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$arr2.each do |d| d.call(); end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Array 2: #{delta}"

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$arr3.each do |d| d.call(); end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Array 3: #{delta}"
gets
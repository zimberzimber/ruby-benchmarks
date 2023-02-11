# This script compares the efficiency of different `get minimum` and `clamping` methods
# Mixing integers with floats in the comparisons on purpose

DEFAULT_COUNT = 100000000

def min(x,y)
	return x if x < y
	return y
end

def max(x,y)
	return x if x > y
	return y
end

def clamp(n, lower, higher)
	return lower if n < lower
	return higher if n > higher
	return n
end

puts "> Number of checks to perform: (default: #{DEFAULT_COUNT})"
count = gets.to_i
if count <= 0
	puts "> Resorting to default: #{DEFAULT_COUNT}"
	count = DEFAULT_COUNT
end

i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	m = [1,2.1].min
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> [x,y].min\t: #{delta}"

# An elvis operator `<condition> ? <x> : <y>` is just a compressed `if <condition> return <x> else return <y>`
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	m = 1 < 2.1 ? 1 : 2.1
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> elvis min\t: #{delta}"

i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	m = min(1, 2.1)
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> method min\t: #{delta}"

i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	m = 2.clamp(1.1, 3.1)
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> ruby clamp\t: #{delta}"

i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	m = clamp(0.5, 1, 2.1)
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> custom clamp\t: #{delta}"



class Numeric 
   def clamp2(min, max)
      return min if min > self
	  return max if max < self
	  return self
   end
   
   def clamp3(min, max)
	return min < self ? min : max > self ? max : self
   end
end


i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	2.clamp2(0.1,3.1)
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> numeric override clamp\t: #{delta}"

i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < count
	2.clamp3(0.1,3.1)
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> numeric override clamp (elvis)\t: #{delta}"


puts nil, "> Jobs done!"
gets
# Compare using a range vs arithmetic + conversion for generating random numbers

DEFAULT_REPEATS = 100000000

puts "> Number of randoms to generate: (default: #{DEFAULT_REPEATS})"
repeats = gets.to_i
if repeats <= 0
	puts "> Resorting to default: #{DEFAULT_REPEATS}"
	repeats = DEFAULT_REPEATS
end

# ========== range, small
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < repeats
	r = rand(0..100)
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Range, small\t: #{delta}"

# ========== range, large
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < repeats
	r = rand(0..100000)
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Range, large\t: #{delta}"

# ========== mult, small
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < repeats
	r = (rand() * 100).to_i
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Mult, small\t: #{delta}"

# ========== mult, large
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < repeats
	r = (rand() * 100000).to_i
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "> Mult, large\t: #{delta}"

puts nil, "> Jobs done!"
gets
# Compare the efficiency of multiplication versus devision

DEFAULT_OPERATION_COUNT = 100000000

puts "> Operation count: (default: #{DEFAULT_OPERATION_COUNT})"
op_count = gets.to_i

if op_count <= 0
  puts "> Setting to default: #{DEFAULT_OPERATION_COUNT}"
  op_count = DEFAULT_OPERATION_COUNT
end



# =========================================================================
puts nil, "> Calculating 10.1 * 0.5"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10.1 * 0.5
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10.0 * 0.5"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10.0 * 0.5
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"


# =========================================================================
puts nil, "> Calculating 10 * 0.5"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 * 0.5
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 * 0.33"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 * 0.33
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 * 0.1"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 * 0.1
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 * 2"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 * 2
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 * 3"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 * 3
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 * 10"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 * 10
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"





# =========================================================================
puts nil, "> Calculating 10 / 2"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 / 2
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 / 3"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 / 3
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 / 10"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 / 10
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 / 0.5"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 / 0.5
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 / 0.33"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 / 0.33
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"

# =========================================================================
puts nil, "> Calculating 10 / 0.1"
i = 0
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while i < op_count
	n = 10 / 0.1
	i += 1
end
delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
puts "Duration:\t#{delta}"








# =========================================================================
puts nil, "> Jobs done!"
gets
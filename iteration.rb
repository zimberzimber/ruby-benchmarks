# This script compares different iteration method efficiencies in sligthly different circumstances
# While the difference wouldn't be as impactful in infrequent calls, it makes a huge difference when you have to iterate over a lot of data frequently
# And while some are more readable/intuitive than others, they're best avoided in such cases

# Ruby arrays are only efficient when the elements are within its initial size
# Values pushed into it will break their efficiency, which impacts iteration

DEFAULT_TOTAL_ELEMENT_COUNT = 100000000

# Dummy class to make an operation in
class Dummy; def call(); return 1 + 1; end; end;

$test_array = nil
$test_hash = nil

# Setup data for testing
def data_setup(initial_count, pushed_count)

  puts "> Creating array with #{initial_count}/#{pushed_count} initial/pushed elements."
  $test_array = Array.new(initial_count)
  

  i = 0
  while i < initial_count
    $test_array[i] = Dummy.new()
    i += 1
  end

  i = 0
  while i < pushed_count
    $test_array.push(Dummy.new())
    i += 1
  end

  puts "> Creating hash table with #{initial_count + pushed_count} elements."
  
  $test_hash = {}
  i = 0
  len = initial_count + pushed_count
  while i < len
    $test_hash[i] = Dummy.new()
    i += 1
  end
end

# Compare array iteration method efficiencies
def array_iteration_benchmark

  # ========== for value in
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  for d in $test_array
    d.call()
  end

  delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
  puts "> [array] for value in\t: #{delta}"
  # ==============================


  # ========== for each do
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  $test_array.each do |d|
    d.call()
  end

  delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
  puts "> [array] for each do\t: #{delta}"
  # ==============================


  # ========== while < len
  len = $test_array.length
  i = 0

  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  while i < len
    $test_array[i].call()
    i += 1
  end

  delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
  puts "> [array] while < len\t: #{delta}"
  # ==============================
  

  # ========== each &
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  $test_array.each(&:call)

  delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
  puts "> [array] each(&:call)\t: #{delta}"
  # ==============================
end

# Compare hash table iteration method efficiencies
def hash_iteration_benchmark

  # ========== For in hash.values
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  arr = $test_hash.values
  for d in arr
    d.call()
  end

  delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
  puts "> [hash] for in .values\t: #{delta}"
  # ==============================


  # ========== Each values
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  $test_hash.each do |k, v|
    v.call()
  end

  delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
  puts "> [hash] each do |k,v|\t: #{delta}"
  # ==============================

  
  # ========== While values
  i = 0

  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  arr = $test_hash.values
  len = arr.length
  while i < len
    arr[i].call()
    i += 1
  end

  delta = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
  puts "> [hash] while < values.len\t: #{delta}"
  # ==============================
end



puts "> Element count: (default: #{DEFAULT_TOTAL_ELEMENT_COUNT})"
element_count = gets.to_i

if element_count <= 0
  puts "> Setting to default: #{DEFAULT_TOTAL_ELEMENT_COUNT}"
  element_count = DEFAULT_TOTAL_ELEMENT_COUNT
end

puts nil, "========== Beginning test with initial elements only =========="
data_setup(element_count, 0)
array_iteration_benchmark()
hash_iteration_benchmark()
$test_array, $test_hash = nil, nil
GC.start()

puts nil, "========== Beginning test with pushed elements only =========="
data_setup(0, element_count)
array_iteration_benchmark()
hash_iteration_benchmark()
$test_array, $test_hash = nil, nil
GC.start()

puts nil, "========== Beginning test with half initial, and half pushed elements =========="
data_setup(element_count / 2, element_count / 2)
array_iteration_benchmark()
hash_iteration_benchmark()
$test_array, $test_hash = nil, nil
GC.start()

puts nil, "> All done!"
gets
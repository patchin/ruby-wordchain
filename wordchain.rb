# Ruby-wordchain
# Constructs a list of words linking one word to another word.
# TODO: Read word list into memory.
# TODO: Construct a graph.
# TODO: Get start and end words.
# TODO: Find a path.
# TODO: Optimize if necessary.

# create list of all words because we will need this frequently
$words = []
File.open("input.txt", "r") do |f|
  f.each_line do |line|
    line.split.each do |x|
     $words << x 
    end     
  end
end

def neighbours(x, y)
  return false if x.length != y.length
  diff = 0;
  for i in 0..x.length
    if x[i] != y[i]
      diff += 1
    end    
  end
  diff <= 1
end

def get_neighbours(x)
  results = []
  $words.each do |y|
    if neighbours(x,y)
      results << y
    end
  end
  results
end

$nodes = Hash.new
$words.each do |x|
  $nodes[x] = get_neighbours(x)
end

#puts nodes
# TODO Generate node file and just read it in rather than generate it
# each time.

#puts "Enter the start word."
#puts "Enter the end word."

def find_path(start, endword, maxdepth=5)
  return [false, nil] if maxdepth == 0
  return [false, nil] if !$nodes[start]
  return [false, nil] if !$nodes[endword]
  if $nodes[start].include?(endword)
    return [true,[start, endword]]
  else
    $nodes[start].each do |y|
      result = find_path(y, endword, maxdepth-1)  
      if result.first
        return [true, result[1].unshift(start)]
      end 
    end
    return [false, nil]
  end
end

puts find_path("HATE", "LOVE")

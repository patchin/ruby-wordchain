# genindex.rb - generates a file of words and their neighbours, speeds up the wordchain.rb program. 

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

# write out node structure to file

File.open("word_graph.txt", "wb") {|f| Marshal.dump($nodes, f)}

#p File.open("foo", "rb") {|f| Marshal.load(f)} 

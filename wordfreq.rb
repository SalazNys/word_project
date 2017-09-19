
class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @contents = File.read(filename).downcase.gsub("--", " ").gsub(/[^a-z0-9\s]/i, "")
    @words = @contents.split(" ").reject{|e| STOP_WORDS.include? e}
    @frequencies = Hash.new(0)
    @words.each do |word|
    @frequencies[word] += 1
    end
    return @frequencies
  end

  def frequency(word)
    if @frequencies.has_key?(word)
      @frequencies[word]
    else
      0
    end
  end


  def frequencies
    @frequencies
  end

  def top_words(number)
    @frequencies.sort { |a, b| [b[1], a[0]] <=> [a[1], b[0]] }[0..(number - 1)]

  end

  def print_report
    top_words(10).each do |x, y|
      puts "#{x} |".rjust(9) + " #{y}".ljust(4) + "*" * y
    end
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end

filename = ARGV[0]

file = File.read(filename)

tag_array = file.scan(/<[^>]*>/)
# puts tag_array
def check_xml_validity(tag_array)
  open_tags = []

  tag_array.each do |tag|
    # puts open_tags.to_s
    unless tag.match(/(\/>|<\?|<!)/)
      if tag[0..1] != "</"
        # puts tag[0..2]
        index = 0
        while tag[index] != " " && tag[index] != ">"
          index += 1
        end
        open_tags.push(tag[1..(index-1)])
      else
        if tag[2..-2] != open_tags.pop
          return "INVALID"
        end
      end
    end
  end
  if open_tags.length > 0
    return "INVALID"
  end
  "VALID"
end

puts check_xml_validity(tag_array)

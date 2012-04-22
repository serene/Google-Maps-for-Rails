require 'rspec/expectations'

def has_same_content_as?(actual, expected)
  #p "entry: #{actual}"
  #p "entry2: #{expected}"
  case actual
  when Array
    case expected
    when Array
      result = true
      #p "where: #{actual.first.class}"
      #trigger recursion if array contains subarrays
      case actual.first
      when Array
        actual.each do |actual_subarray|
          #p "actual_subarray: #{actual_subarray}"
          bool = false
          expected.each do |expected_subarray|
           # p "expected_subarray: #{expected_subarray}"
            bool = bool || has_same_content_as?(actual_subarray, expected_subarray)
            #p "comparison: #{bool}"
          end
          result = result && bool
        end
        result
      else
        (actual - expected).empty?
        #p "actual: #{actual}"
        #p "expected: #{expected}"
        #p "comparison = #{temp}"
        #temp
      end
    else 
      false
    end
  else
    false
  end
end

RSpec::Matchers.define :have_same_position_as do |position_hash|
  match do |object|
    object.send(object.gmaps4rails_options[:lat_column]) == position_hash[:latitude] && object.send(object.gmaps4rails_options[:lng_column]) == position_hash[:longitude]
  end
end

RSpec::Matchers.define :be_same_json_as do |expected|
  match do |actual|
    has_same_content_as?(JSON.parse(actual), JSON.parse(expected))
  end
  failure_message_for_should do |actual|
    "Both object don't have the same content. Beware though, be sure to compare only arrays."
  end
end
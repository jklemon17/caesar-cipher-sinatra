require 'sinatra'
#require 'sinatra/reloader'

get '/' do
  erb :index, :locals => {:text => caesar_cipher(params['text'],params['shift'].to_i)}
end

#get '/*' do
#
#end

def caesar_cipher(text, shift=0)
  return text if shift == 0 || text == "" || shift.nil? || text.nil?
  standard_key_caps = ("A".."Z").to_a
  standard_key_lower = ("a".."z").to_a

  while shift < 0 do
    shift += 26
  end

  i = shift % 26


  shift_key_caps = []
  range = ('A'..'Z').to_a
  range.each do |x|
    shift_key_caps[i] = x
    i+=1
    i=0 if i >= 26
  end

  i=shift
  shift_key_lower = []
  range = ('a'..'z').to_a
  range.each do |x|
    shift_key_lower[i] = x
    i+=1
    i=0 if i >= 26
  end

  text_mod = ""
  text.each_char do |x|
    character = x
    if standard_key_caps.include?(x)
      offset = shift_key_caps.index(x)
      character = standard_key_caps[offset]
    elsif standard_key_lower.include?(x)
      offset = shift_key_lower.index(x)
      character = standard_key_lower[offset]
    end
    text_mod = text_mod + character
  end
  text_mod
end

require 'sinatra'

# code from numerology_v2.rb to calculate birth path and return birth-path message
# Adds up individual digits of MMDDYYYY birthdate

def first_num(birthdate)
number = birthdate[0].to_i + birthdate[1].to_i + birthdate[2].to_i + birthdate[3].to_i + birthdate[4].to_i + birthdate[5].to_i + birthdate[6].to_i + birthdate[7].to_i
end

# Adds up digits of summed birthdate when previous math results in 2-digit value

def nn(number)
number = number.to_s
number = number[0].to_i + number[1].to_i
if number > 9
  number = number.to_s
  number = number[0].to_i + number[1].to_i
end
return number
end





# Returns message based on birth path number

def birth_path_msg(number)
case number
when number = 1 then message = "One is the leader. The number one indicates the ability to stand alone, and is a strong vibration. Ruled by the Sun."
when number = 2 then message = "This is the mediator and peace-lover. The number two indicates the desire for harmony. It is a gentle, considerate, and sensitive vibration. Ruled by the Moon."
when number = 3 then message = "Number Three is a sociable, friendly, and outgoing vibration. Kind, positive, and optimistic, Threes enjoy life and have a good sense of humor. Ruled by Jupiter."
when number = 4 then message = "<p>Your numerology number is #{number}. This is the worker. Practical, with a love of detail, Fours are trustworthy, hard-working, and helpful. Ruled by Uranus."
when number = 5 then message = "This is the freedom lover. The number five is an intellectual vibration. These are 'idea' people with a love of variety and the ability to adapt to most situations. Ruled by Mercury."
when number = 6 then message = "This is the peace lover. The number six is a loving, stable, and harmonious vibration. Ruled by Venus."
when number = 7 then message = "This is the deep thinker. The number seven is a spiritual vibration. These people are not very attached to material things, are introspective, and generally quiet. Ruled by Neptune."
when number = 8 then message = "This is the manager. Number Eight is a strong, successful, and material vibration. Ruled by Saturn."
when number = 9 then message = "This is the teacher. Number Nine is a tolerant, somewhat impractical, and sympathetic vibration. Ruled by Mars."
else message = "Your numerology number is #{number}.  Wait!  Your birth path number isn't 1-9!!"
end
end

def setup_index_view
  birthdate = params[:birthdate]
  number = first_num(birthdate) 
  path_number = nn(number)
  @message = birth_path_msg(path_number)
end

def valid_birthdate(input)
  if (input.length==8) && (input.match(/^[0-9]+[0-9]$/))
    return true
  else
    return false
  end
end


get '/' do
  erb :form
end

post '/' do
  birthdate = params[:birthdate]
  if valid_birthdate(birthdate)
   number = first_num(params[:birthdate].gsub("-",""))
   path_number = nn(number)
   redirect "/message/#{path_number}"
  else 
   @error = "You should enter a valid birthdate in the form of mmddyyyy."
   erb :form
  end
  #erb :index
end

get '/message/:path_number' do
  path_number = params[:path_number].to_i
  @message = birth_path_msg(path_number)
  erb :index
end

get '/:birthdate' do
  setup_index_view
  erb :index
end

get '/newpage/' do
    erb :newpage
end


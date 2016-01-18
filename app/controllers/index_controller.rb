require 'sinatra'

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


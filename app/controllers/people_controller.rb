get '/people' do
  @people = Person.all
  erb :"/people/index"
end

get '/people/:id' do
  @person = Person.find(params[:id])
  birthdate_string = @person.birthdate.strftime("%m%d%Y")
  number = Person.first_num(birthdate_string)
  path_number = Person.nn(number)
  @message = Person.birth_path_msg(path_number)

  erb :"people/show"
end
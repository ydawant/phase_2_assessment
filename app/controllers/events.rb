get '/event/:user_id/create' do
  erb :create_new
end

post '/event/create' do
  Event.create(params[:event])
  redirect '/'
end

post '/event/edit' do
  event = Event.find(params[:event_id])
  event.update_attributes(params[:event])
  redirect '/'
end

get '/event/:event_id' do
  @event = Event.find(params[:event_id])
  erb :event
end

get '/event/destroy/:event_id' do
  Event.find(params[:event_id]).destroy
  redirect '/'
end

get '/event/edit/:event_id' do
  @event = Event.find(params[:event_id])
  erb :edit_event
end

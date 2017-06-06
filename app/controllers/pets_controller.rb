class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(:name => params[:pet][:name])
    @owner = Owner.find_by(:id => params[:pet][:owner_id].first) unless params[:pet][:owner_id].nil?
    @owner = Owner.create(:name => params[:owner][:name]) if @pet.owner.nil? && !params[:owner][:name].nil?
    if @owner
      @owner.pets << @pet
      @owner.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end

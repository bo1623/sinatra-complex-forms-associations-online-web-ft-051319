class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners=Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet=Pet.create(params[:pet])

    if !params["owner"]["name"].empty?
      @owner=Owner.create(params["owner"])
      @pet.owner = @owner
    end

    @pet.save #this is required because we didn't use the shovel operator like we did in the owners_controller, so it didnt
    #automatically trigger SQL to save this new data to our database

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet=Pet.find(params[:id])
    @owners=Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet=Pet.find(params[:id])
    @pet.update(params[:pet])

    if !params["owner"]["name"].empty?
      @owner=Owner.create(params["owner"])
      @pet.owner = @owner
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end

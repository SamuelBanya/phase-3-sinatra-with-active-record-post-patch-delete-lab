class ApplicationController < Sinatra::Base
  set default_content_type: "application/json"
  
  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end
  
  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_goods = BakedGood.by_price
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_good = BakedGood.by_price.first
    baked_good.to_json
  end

  # POST /baked_goods: creates a new baked good in the database, 
  # and returns data for the newly created baked good as JSON. 
  # The request will receive an object like this as params:
  post "/baked_goods" do 
    # Related fields for 'BakedGood' class in 'db/migrate':
      # t.string :name
      # t.integer :price
      # t.integer :bakery_id
    baked_good = BakedGood.create(
      # First attempt:
      # :name params[:name], 
      # :price params[:price], 
      # :bakery_id params[:bakery_id])
      name: params[:name],
      price: params[:price],
      bakery_id: params[:bakery_id]
    )
    baked_good.to_json()
  end

  # PATCH /bakeries/:id: updates the name of the bakery in the database, 
  # and returns data for the updated bakery as JSON. 
  # The request will receive an object like this as params:
  patch "/bakeries/:id" do 
    bakery = Bakery.find(params[:id])
    # First attempt:
    # bakery.name = params[:name]
    bakery.update(
      name: params[:name]
    )
    bakery.to_json()
  end

  # DELETE /baked_goods/:id: deletes the baked_good from the database.
  delete "/baked_goods/:id" do 
    baked_good = BakedGood.find(params[:id])
    baked_good.destroy()
    baked_good.to_json()
  end

end

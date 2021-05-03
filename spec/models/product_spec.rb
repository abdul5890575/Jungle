require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'should create product if all validations are met' do
    @category = Category.new(name: "New Category")
    @product = Product.new(name: "New Product", price_cents: 2000, quantity: 15, :category => @category)
    expect(@product).to be_valid
  end

  it 'should not create product if name does not exist' do
    @category = Category.new(name: "New Category")
    @product = Product.new(name: nil, price_cents: 2000, quantity: 15, :category => @category)
    expect(@product).not_to be_valid
  end

  it 'should not create product if price does not exist' do
    @category = Category.new(name: "New Category")
    @product = Product.new(name: "New Category", price_cents: nil, quantity: 15, :category => @category)
    expect(@product).not_to be_valid
  end

  it 'should not create product if quantity does not exist' do
    @category = Category.new(name: "New Category")
    @product = Product.new(name: "New Category", price_cents: 2000, quantity: nil, :category => @category)
    expect(@product).not_to be_valid
  end

  it 'should not create product if category is missing' do
    @category = nil
    @product = Product.new(name: "New Category", price_cents: 2000, quantity: 2, :category => @category)
    expect(@product.errors).not_to include("can\'t be blank")
  end

end

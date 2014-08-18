class SellProduct
  include Interactor::Organizer

  organize CheckIfSellable, PutProductOnSale, GenerateSellReceipt
end

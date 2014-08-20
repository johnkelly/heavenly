class BuyProduct
  include Interactor::Organizer

  organize  CheckIfBuyable,
            CalculateTotal,
            AuthorizeCreditCard,
            GenerateBuyReceipt,
            GenerateOrder,
            MarkProductAsSold
end

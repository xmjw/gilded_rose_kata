class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == 'Sulfuras, Hand of Ragnaros'
        next
      end

      item.sell_in -= 1

      case(item.name)
      when 'Aged Brie'
        increment_quality(item)
        increment_quality(item) if item.sell_in < 0
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_backstage_quality(item)
        item.quality = 0 if item.sell_in < 0
      else
        decrement_quality(item)
        decrement_quality(item) if item.sell_in < 0
      end

    end
  end

  private

  def increment_quality(item)
    item.quality += 1 unless max_quality?(item)
  end

  def decrement_quality(item)
    item.quality -= 1 unless item.quality <= 0
  end

  def update_backstage_quality(item)
    increment_quality(item)
    if item.sell_in < 10
      increment_quality(item)
    end
    if item.sell_in < 5
      increment_quality(item)
    end
  end

  def max_quality?(item)
    item.quality >= 50
  end

end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]


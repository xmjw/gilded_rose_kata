class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == 'Sulfuras, Hand of Ragnaros'
        next
      end

      if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
        if item.quality > 0
          item.quality -= 1
        end
      else
        if !max_quality?(item)
          item.quality += 1
          if item.name == 'Backstage passes to a TAFKAL80ETC concert'
            if item.sell_in < 11
              item.quality += 1
            end
            if item.sell_in < 6
              item.quality += 1
            end
          end
        end
      end

      item.sell_in -= 1

      if item.sell_in < 0
        case(item.name)
        when 'Backstage passes to a TAFKAL80ETC concert'
          item.quality = 0
        when "Aged Brie"
          if !max_quality?(item)
            item.quality += 1
          end
        else
          if item.quality > 0
            item.quality -= 1
          end
        end
      end
    end
  end

  private

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


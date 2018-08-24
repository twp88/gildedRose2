require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  subject { GildedRose.new(items) }

  describe '#update_quality' do
    context 'when the item is normal' do
      let(:items) { [normal_item, no_sell_in_item] }
      let(:normal_item) { Item.new('foo', 2, 2) }
      let(:no_sell_in_item) { Item.new('foo', 0, 2) }

      it 'does not change the name' do
        expect { subject.update_quality }.not_to(change { items[0].name })
      end

      it 'degrades sellIn' do
        expect { subject.update_quality }.to change { normal_item.sell_in }
          .by(-1)
      end

      it 'degrades quality' do
        expect { subject.update_quality }.to change { normal_item.quality }
          .by(-1)
      end

      it 'degrades quality x2' do
        expect { subject.update_quality }
          .to change { no_sell_in_item.quality }
          .by(-2)
      end
    end
  end
end

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  subject { GildedRose.new(items) }

  describe '#update_quality' do
    context 'when the item is normal' do
      let(:items) { [normal_item, no_sell_in_item, zero_quality_item] }
      let(:normal_item) { Item.new('foo', 2, 2) }
      let(:no_sell_in_item) { Item.new('no_sell', 0, 4) }
      let(:zero_quality_item) { Item.new('no_sell', 0, 0) }

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

      it 'does not degrade quality lower than 0' do
        expect { subject.update_quality }
          .not_to(change { zero_quality_item.quality })
      end
    end
  end

  describe '#update_quality' do
    context 'when the item is aged brie' do
      let(:items) { [aged_brie_item] }
      let(:aged_brie_item) { Item.new('Aged Brie', 2, 2) }

      it 'does not change the name' do
        expect { subject.update_quality }.not_to(change { items[0].name })
      end

      it 'degrades sellIn' do
        expect { subject.update_quality }.to change { aged_brie_item.sell_in }
          .by(-1)
      end

      it 'increases quality with age' do
        expect { subject.update_quality }.to change { aged_brie_item.quality }
          .by(+1)
      end
    end
  end

  describe '#update_quality' do
    context 'when the item is sulfuras' do
      let(:items) { [sulfuras_item] }
      let(:sulfuras_item) { Item.new('Sulfuras, Hand of Ragnaros', 2, 2) }

      it 'does not change the name' do
        expect { subject.update_quality }.not_to(change { items[0].name })
      end

      it 'has a quality of 80' do
        expect { subject.update_quality }
          .to change { sulfuras_item.quality }.to 80
      end
    end
  end

  describe '#update_quality' do
    context 'when the item is backstage pass' do
      let(:items) do
        [backstage_pass1,
         backstage_pass2,
         backstage_pass3,
         backstage_pass4]
      end

      let(:backstage_pass1) do
        Item.new(
          'Backstage passes to a TAFKAL80ETC concert',
          15,
          2
        )
      end

      let(:backstage_pass2) do
        Item.new(
          'Backstage passes to a TAFKAL80ETC concert',
          10,
          2
        )
      end

      let(:backstage_pass3) do
        Item.new(
          'Backstage passes to a TAFKAL80ETC concert',
          5,
          2
        )
      end

      let(:backstage_pass4) do
        Item.new(
          'Backstage passes to a TAFKAL80ETC concert',
          0,
          2
        )
      end

      it 'does not change the name' do
        expect { subject.update_quality }.not_to(change { items[0].name })
      end

      it 'increases quality x1' do
        expect { subject.update_quality }.to change { backstage_pass1.quality }
          .by(+1)
      end

      it 'increases quality x2' do
        expect { subject.update_quality }.to change { backstage_pass2.quality }
          .by(+2)
      end

      it 'increases quality x3' do
        expect { subject.update_quality }.to change { backstage_pass3.quality }
          .by(+3)
      end

      it 'decreases quality to 0' do
        expect { subject.update_quality }.to change { backstage_pass4.quality }
          .to(0)
      end
    end
  end
end

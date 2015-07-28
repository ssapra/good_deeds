require 'rails_helper'

describe LegislatorQuery do
  before do
    @legislator_1 = create(:legislator, title: 'Sen', party: 'D', state: 'AZ')
    @legislator_2 = create(:legislator, title: 'Rep', party: 'D', state: 'IL')
    @legislator_3 = create(:legislator, title: 'Sen', party: 'R', state: 'OH')
  end

  describe '#search' do
    context 'by name' do
      let(:legislator_query) { LegislatorQuery.new(Legislator.all, @legislator_1.firstname) }

      it 'searches for legislators who match the name' do
        expect(legislator_query.search.count).to eq(1)
      end
    end

    context 'by party' do
      let(:legislator_query) { LegislatorQuery.new(Legislator.all, 'Democratic') }

      it 'searches for legislators who are Democratic' do
        expect(legislator_query.search.count).to eq(2)
      end
    end

    context 'by state' do
      let(:legislator_query) { LegislatorQuery.new(Legislator.all, 'Arizona') }

      it 'searches for legislators who represent Arizona' do
        expect(legislator_query.search.count).to eq(1)
      end
    end

    context 'by title' do
      let(:legislator_query) { LegislatorQuery.new(Legislator.all, 'Senator') }

      it 'searches for legislators who are Senators' do
        expect(legislator_query.search.count).to eq(2)
      end
    end
  end
end

require 'rails_helper'

describe LegislatorQuery do
  before do
    @legislator_1 = create(:legislator, title: 'Sen', party: 'D', state: 'AZ', district: '8')
    @legislator_2 = create(:legislator, title: 'Rep', party: 'D', state: 'IL', district: '9')
    @legislator_3 = create(:legislator, title: 'Sen', party: 'R', state: 'IL', district: '1')
    @il_zipcode = '60564'
    create(:congressional_district, zipcode: @il_zipcode, state: 'IL', congressional_district_id: 1)
    create(:congressional_district, zipcode: @il_zipcode, state: 'IL', congressional_district_id: 9)
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

    context 'by zipcode' do
      let(:legislator_query) { LegislatorQuery.new(Legislator.all, @il_zipcode) }

      it 'searches for legislators who server the zipcode 12345' do
        expect(legislator_query.search.count).to eq(2)
      end
    end
  end
end

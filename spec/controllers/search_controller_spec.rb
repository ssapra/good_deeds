require 'rails_helper'

describe SearchController do
  render_views
  context "JSON" do
    describe '#index' do
      context 'searching for state' do
        before do
          create(:legislator, state: 'IL')
          data = { format: 'json', query: 'IL' }
          get(:index, data)
          @json = JSON.parse(response.body)
        end

        it 'contains one legislator' do
          expect(@json['legislators'].length).to eq(1)
        end
      end

      context 'searching for bill content' do
        before do
          create(:bill, short_title: 'American Super Computing Leadership Act')
          data = { format: 'json', query: 'american leadership' }
          get(:index, data)
          @json = JSON.parse(response.body)
        end

        it 'contains one bill' do
          expect(@json['bills'].length).to eq(1)
        end
      end
    end
  end
end

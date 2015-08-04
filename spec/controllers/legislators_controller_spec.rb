require 'rails_helper'

describe LegislatorsController do
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
    end
  end
end

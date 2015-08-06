require 'rails_helper'

describe LegislatorsController, type: :controller do
  render_views
  context 'JSON' do
    describe '#index' do
      context 'searching for state' do
        before do
          create(:legislator, state: 'IL')
          params = { format: 'json', query: 'IL' }
          get(:index, params)
          @json = JSON.parse(response.body)
        end

        it 'contains one legislator' do
          expect(@json['legislators'].length).to eq(1)
        end
      end
    end
  end
end

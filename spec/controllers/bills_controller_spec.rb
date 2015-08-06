require 'rails_helper'

describe BillsController do
  render_views
  context 'JSON' do
    describe '#index' do
      context 'searching for bill content' do
        before do
          create(:bill, short_title: 'American Super Computing Leadership Act')
          params = { format: 'json', query: 'american leadership' }
          get(:index, params)
          @json = JSON.parse(response.body)
        end

        it 'contains one bill' do
          expect(@json['bills'].length).to eq(1)
        end
      end
    end
  end
end

require 'rails_helper'

describe BillsController do
  render_views
  context 'JSON' do
    let(:default_params) { { format: 'json' } }
    describe '#index' do
      context 'searching for bill content' do
        before do
          create(:bill, short_title: 'American Super Computing Leadership Act')
          params = default_params.merge({ query: 'american leadership' })
          get(:index, params)
          @json = JSON.parse(response.body)
        end

        it 'contains one bill' do
          expect(@json['bills'].length).to eq(1)
        end
      end
    end

    describe '#show' do
      before do
        @bill = create(:bill)
        create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'senate')
        create(:bill_action, bill_id: @bill.id)
        params = default_params.merge({ bill_id: @bill.bill_id })
        get(:show, params)
        @json = JSON.parse(response.body)
      end

      it 'contains basic bill attributes' do
        expect(@json['bill_type']).to eq(@bill.bill_type)
        expect(@json['bill_id']).to eq(@bill.bill_id)
        expect(@json['chamber']).to eq(@bill.chamber)
        expect(@json['short_title']).to eq(@bill.short_title)
      end

      it 'contains two actions' do
        expect(@json['actions'].length).to eq(2)
      end

      it 'contains one important action' do
        expect(@json['important_actions'].length).to eq(1)
      end
    end
  end
end

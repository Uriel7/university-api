require 'rails_helper'

RSpec.describe 'Subject API', type: :request do
  #Set data
  let!(:subjects) { create_list(:subject, 10) }
  let(:subject_id) { subjects.first.id }

  # Test suite for GET /subjects
  describe 'GET /subjects' do
    before { get '/subjects' }

    it 'return subjects' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /subjects/:id
  describe 'GET /subjects/:id' do
    before { get "/subjects/#{subject_id}" }

    context 'when the subject exists' do
      it 'return subject' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(subject_id)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the subject does not exists' do
      let(:subject_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Subject with 'id'=100/)
      end
    end
  end

  # Test suite for POST /subjects
  describe 'POST /subjects' do
    let(:valid_attributes) { { name: 'Matematicas' } }

    context 'when the request is valid' do
      before { post '/subjects', params: valid_attributes }


      it 'return subject created' do
        expect(json).not_to be_empty
        expect(json['name']).to eq('Matematicas')
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/subjects', params: { name: nil} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /subjects/:id
  describe 'PUT /subjects/:id' do
    let(:valid_attribute) { {name: 'Mátematicas'} }
    
    context 'when the record exists' do
      before { put "/subjects/#{subject_id}", params: valid_attribute }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'subjects updated' do
        expect(response.body).to be_empty
      end
    end
  end

  # Test suite for DELETE /subjects/:id
  describe 'DELETE /subjects/:id' do
    before { delete "/subjects/#{subject_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
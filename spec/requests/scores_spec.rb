require 'rails_helper'

RSpec.describe 'Score API', type: :request do
  # initialize test data
  let!(:student) { create(:student) }
  let!(:subject) { create(:subject) }
  let!(:scores) { create_list(:score, 10, student_id: student.id, subject_id: subject.id) }
  let(:student_id) { student.id }
  let(:id) { scores.first.id }

  # Test suite for GET /students/:student_id/scores/
  describe 'GET /students/:student_id/scores' do
    before { get "/students/#{student_id}/scores/" }

    it 'return scores' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite GET students/:student_id/scores/:id
  describe 'GET /students/:student_id/scores/:id' do
    before { get "/students/#{student_id}/scores/#{id}" }
    
    context 'when the record exists' do
      it 'returns the score' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'retunrs a not found message' do
        expect(repsonse.body).to match(/Couldn't find Score with 'id'=100/)
      end
    end
  end

  # Test suite POST /students/:student_id/scores
  describe 'POST /students/:student_id/scores' do
    let(:valid_attributes) { { student_id: student_id, subject_id: subject.id, qualification: 9.5 } }

    context 'when the request is valid' do
      before { post "/students/#{student_id}/scores", params: valid_attributes }
      
      it 'creates a score' do
        expect(json['student_id']).to eq(student_id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/students/#{student_id}/score", params: { student_id: student_id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation faiulure message' do
        expect(response.body).to match(/Validation failed: /)
      end
    end
  end

  # Test suite PUT /students/:student_id/scores/:id
  describe 'PUT /students/:student_id/scores/:id' do
    let(:valid_attribute) { { qualification: 9.1} }

    context 'when the record exists' do
      before { put "/students/#{student_id}/scores/#{id}", params: valid_attribute }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite DELETE /students/:student_id/scores/:id
  describe 'DELETE /students/:student_id/scores/:id' do
    before { delete "/students/#{student_id}/scores/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
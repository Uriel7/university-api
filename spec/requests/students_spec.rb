require 'rails_helper'

RSpec.describe 'Student API', type: :request do
  # initialize test data
  let!(:students) { create_list(:student, 10) }
  let(:student_id) { students.first.id }

  # Test suite for GET /students
  describe 'GET /students' do
    # make HTTP get request before each example
    before { get '/students'}

    it 'return students' do
      expect(json).not_be_empty
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /students/:id
  describe 'GET /students/:id' do
    #make HTTP get request before
    before { get "/students/#{student_id}" }

    context 'when the record exists' do
      it 'returns the student' do
        expect(json).not_be_empty
        expect(json['id']).to eq(student_id)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:student_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'return a not found message' do
        expect(response.body).to match(/Couldn't find Student/)
      end
    end
  end

  # Test suite for POST /students
  describe 'POST /students' do
    # valid payload
    let(:valid_attributes) { { name: 'Jose Uriel', surname: 'Salazar Zuñiga', birthdate: Date.today } }
    
    context 'when the request is valid' do
      before { post '/students', params: valid_attributes }
      
      it 'creates a student' do
        expect(json['name']).to eq('Jose Uriel')
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/students', params: { name: 'Uriel' } }
      
      it 'returns status code 422' do
        expect(message).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Surname cant't be blank/)
      end
    end
  end

  # Test suite for PUT /students/:id
  describe 'PUT /students/:id' do
    let(:valid_attributes) { { name: 'Cristina'} }
    
    context 'when the record exists' do
      before { put "/students/#{student_id}" , params: valid_attributes }
      
      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /students/:id
  describe 'DELETE /students/:id' do
    before { delete "/students/#{student_id} "}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
from django.shortcuts import render
import os
# Create your views here.
def index(request):
  firebase_key = os.environ.get('FIREBASE_API_KEY', 'Ключ не найден')
  return render(request, "index.html", {'firebase_api_key': firebase_key})
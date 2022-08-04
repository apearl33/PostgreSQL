from django.shortcuts import render
from django.http import HttpResponse
from django.http import Http404

from .models import User
from .models import Transaction

# Write a query to show all items that user1 has checked out with the corresponding checkout_time
# Write a query to show all users who checked out items before September 3 2018
def home(request):
    user =  User.objects.get(id=1)
    transactions =  Transaction.objects.filter(checkout_time__lte = "2018-09-03 00:00:00")
    return render(request, 'home.html', {'user': user, 'transactions': transactions})

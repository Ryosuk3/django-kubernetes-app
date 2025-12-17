from django.http import HttpResponse
import socket

def home(request):
    return HttpResponse(f"Hello! I am running on Pod Hostname: {socket.gethostname()}")

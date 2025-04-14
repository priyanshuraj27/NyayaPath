from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserSerializer
from rest_framework_simplejwt.views import TokenObtainPairView

@api_view(['POST'])
def signup(request):
    username = request.data.get('username')
    password = request.data.get('password')
    email = request.data.get('email')
    full_name = request.data.get('fullName')

    if not username or not password:
        return Response({'error': 'Username and password are required'}, status=status.HTTP_400_BAD_REQUEST)

    if User.objects.filter(username=username).exists():
        return Response({"error": "Username already exists."}, status=status.HTTP_400_BAD_REQUEST)

    try:
        first_name = ''
        last_name = ''
        if full_name:
            name_parts = full_name.strip().split(' ', 1)
            first_name = name_parts[0]
            if len(name_parts) > 1:
                last_name = name_parts[1]

        user = User.objects.create_user(
            username=username,
            password=password,
            email=email,
            first_name=first_name,
            last_name=last_name
        )
        user.save()
    except Exception as e:
        return Response({"error": "Something went wrong during user creation."}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    serializer = UserSerializer(user)
    return Response(serializer.data, status=status.HTTP_201_CREATED)

# JWT Login view (unchanged)
class CustomTokenObtainPairView(TokenObtainPairView):
    pass

# JWT Logout view (unchanged)
@api_view(['POST'])
def logout(request):
    # print("🔒 [DEBUG] Logout called")
    return Response({'message': 'Logout successful. Please remove the token from client storage.'}, status=status.HTTP_200_OK)

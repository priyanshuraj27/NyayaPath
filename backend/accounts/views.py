from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserSerializer
from rest_framework_simplejwt.views import TokenObtainPairView

# Signup view with debug prints
@api_view(['POST'])
def signup(request):
    print("\n🟡 [DEBUG] /signup endpoint hit")

    username = request.data.get('username')
    password = request.data.get('password')
    email = request.data.get('email')

    # print(f"📨 Payload received -> username: {username}, email: {email}, password: {'*' * len(password) if password else 'None'}")

    if not username or not password:
        # print("❌ [ERROR] Username or password missing")
        return Response({'error': 'Username and password are required'}, status=status.HTTP_400_BAD_REQUEST)

    if User.objects.filter(username=username).exists():
        # print(f"❌ [ERROR] Username '{username}' already exists")
        return Response({"error": "Username already exists."}, status=status.HTTP_400_BAD_REQUEST)

    try:
        user = User.objects.create_user(username=username, password=password, email=email)
        user.save()
        # print("✅ [SUCCESS] User created successfully")
    except Exception as e:
        # print(f"❌ [ERROR] Failed to create user: {e}")
        return Response({"error": "Something went wrong during user creation."}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    serializer = UserSerializer(user)
    # print(f"📦 [DEBUG] Serialized User Data: {serializer.data}")

    return Response(serializer.data, status=status.HTTP_201_CREATED)

# JWT Login view (unchanged)
class CustomTokenObtainPairView(TokenObtainPairView):
    pass

# JWT Logout view (unchanged)
@api_view(['POST'])
def logout(request):
    # print("🔒 [DEBUG] Logout called")
    return Response({'message': 'Logout successful. Please remove the token from client storage.'}, status=status.HTTP_200_OK)

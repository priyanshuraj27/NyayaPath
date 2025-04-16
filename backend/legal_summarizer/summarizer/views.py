from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from transformers import TFAutoModelForSeq2SeqLM, AutoTokenizer
import tensorflow as tf

# Load model once at the top
model = TFAutoModelForSeq2SeqLM.from_pretrained("t5-small")
tokenizer = AutoTokenizer.from_pretrained("t5-small")
@csrf_exempt
def summarize(request):
    if request.method == "POST":
        import json
        body = json.loads(request.body)
        input_text = body.get("text", "")

        input_ids = tokenizer.encode("summarize: " + input_text, return_tensors="tf", max_length=512, truncation=True)
        output = model.generate(input_ids, max_length=150, min_length=30, length_penalty=2.0, num_beams=4, early_stopping=True)
        summary = tokenizer.decode(output[0], skip_special_tokens=True)

        return JsonResponse({"summary": summary})
from django.shortcuts import render

# Create your views here.

<template>
  <div class="container">
    <h1 class="display-4">Text Summarizer</h1>
    <div class="form-group">
      <label for="inputText">Enter text to summarize:</label>
      <textarea class="form-control" v-model="inputText" id="inputText" rows="6" placeholder="Enter text"></textarea>
    </div>
    <button class="btn btn-primary" @click="summarizeText">Summarize</button>
    <div v-if="summary" class="mt-4">
      <h2 class="h4">Summary:</h2>
      <p>{{ summary }}</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      inputText: '',
      summary: null,
    };
  },
  methods: {
    summarizeText() {
      const options = {
        method: 'POST',
        url: 'https://api.cohere.ai/v1/summarize',
        headers: {
          accept: 'application/json',
          'content-type': 'application/json',
          authorization: 'Bearer p3hMtWIDy3omAURlMmeO6DTzVFugTA0L5zN219JJ',
        },
        data: {
          text: this.inputText,
          length: 'medium',
          format: 'paragraph',
          model: 'command',
          extractiveness: 'low',
          temperature: 0.3,
          language_code: 'fr',
        },
      };

      axios
        .request(options)
        .then((response) => {
          this.summary = response.data.summary;
        })
        .catch((error) => {
          console.error(error);
        });
    },
  },
};
</script>

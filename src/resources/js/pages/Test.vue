<template>
  <div class="min-h-screen bg-gray-50 p-8">
    <div class="max-w-4xl mx-auto">
      <h1 class="text-2xl font-semibold text-gray-800 mb-6">Nuova nota</h1>

      <div class="grid grid-cols-2 gap-6">
        <!-- Editor -->
        <div class="bg-white rounded-2xl shadow-md p-6">
          <h2 class="text-sm font-medium text-gray-500 mb-3">Scrivi</h2>
          <textarea
            v-model="content"
            placeholder="Scrivi in markdown... **grassetto**, *corsivo*, # titolo"
            rows="15"
            class="w-full border border-gray-300 rounded-lg px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none font-mono"
          />
        </div>

        <!-- Anteprima -->
        <div class="bg-white rounded-2xl shadow-md p-6">
          <h2 class="text-sm font-medium text-gray-500 mb-3">Anteprima</h2>
          <div
            v-html="renderedContent"
            class="prose prose-sm max-w-none"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import DOMPurify from 'dompurify'
import { marked } from 'marked'
import { computed, ref } from 'vue'

const content = ref('')

// ogni volta che "content" cambia, renderedContent si ricalcola automaticamente
const renderedContent = computed(() => {
  return DOMPurify.sanitize(marked(content.value) as string)
})
</script>
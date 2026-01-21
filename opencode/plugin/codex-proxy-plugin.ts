import type { Plugin } from '@opencode-ai/plugin';

/**
 * Custom fetch wrapper that removes max_output_tokens and max_completion_tokens
 * from the request body before sending to the API.
 *
 * @param input - The request URL or Request object
 * @param init - Optional request init options
 * @returns The fetch response
 */
async function codexFetch(input: Request | string | URL, init?: RequestInit): Promise<Response> {
  if (!init?.body || typeof init.body !== 'string') {
    return globalThis.fetch(input, init);
  }

  try {
    const originalBody = JSON.parse(init.body);

    // Remove token limit parameters that may cause issues
    delete originalBody.max_output_tokens;
    delete originalBody.max_completion_tokens;

    // disable_response_storage = true
    // Remove previous_response_id to avoid Item

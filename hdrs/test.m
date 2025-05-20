Conventions
Model names
Model names follow a model:tag format, where model can have an optional namespace such as example/model. Some examples are orca-mini:3b-q4_1 and llama3:70b. The tag is optional and, if not provided, will default to latest. The tag is used to identify a specific version.

Durations
All durations are returned in nanoseconds.

Streaming responses
Certain endpoints stream responses as JSON objects. Streaming can be disabled by providing {"stream": false} for these endpoints.

Generate a completion
POST /api/generate
Generate a response for a given prompt with a provided model. This is a streaming endpoint, so there will be a series of responses. The final response object will include statistics and additional data from the request.
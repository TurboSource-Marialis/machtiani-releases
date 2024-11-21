const { merge } = require('openapi-merge');
const fs = require('fs');

const oas1 = require('./5071-openapi.json');
const oas2 = require('./5070-openapi.json');

const mergeResult = merge([
  { oas: oas1 },
  { oas: oas2 }
]);

if (mergeResult.output) {
  fs.writeFileSync('merged-openapi.json', JSON.stringify(mergeResult.output, null, 2));
  console.log('Merged OpenAPI file created: merged-openapi.json');
} else {
  console.error('Error merging files:', mergeResult.message);
}


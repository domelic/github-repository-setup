#!/usr/bin/env node
/**
 * Metadata Completeness Check
 *
 * Validates that every workflow template file has a corresponding entry
 * in workflow-metadata.yaml. This ensures the metadata index stays in
 * sync with the actual templates.
 *
 * Exit codes:
 *   0 - All workflows have metadata entries
 *   1 - Missing or extra entries found
 */

const fs = require('fs');
const path = require('path');
const yaml = require('yaml');

const TEMPLATES_DIR = path.join(__dirname, '..', 'templates', 'workflows');
const METADATA_FILE = path.join(TEMPLATES_DIR, 'workflow-metadata.yaml');

// Files to exclude from the check (non-workflow files in the workflows directory)
const EXCLUDED_FILES = new Set([
  'workflow-metadata.yaml',
  'workflow-metadata.schema.json',
  'README.md'
]);

function getWorkflowFiles() {
  const files = fs.readdirSync(TEMPLATES_DIR);
  return files
    .filter(f => f.endsWith('.yml') && !EXCLUDED_FILES.has(f))
    .sort();
}

function getMetadataEntries() {
  const content = fs.readFileSync(METADATA_FILE, 'utf-8');
  const metadata = yaml.parse(content);
  const entries = new Map();

  for (const [id, entry] of Object.entries(metadata.metadata || {})) {
    entries.set(entry.file, id);
  }

  return entries;
}

function main() {
  console.log('Checking workflow metadata completeness...\n');

  const workflowFiles = getWorkflowFiles();
  const metadataEntries = getMetadataEntries();

  const missing = [];
  const extra = [];

  // Check for workflows missing metadata
  for (const file of workflowFiles) {
    if (!metadataEntries.has(file)) {
      missing.push(file);
    }
  }

  // Check for metadata entries without corresponding workflow files
  const workflowSet = new Set(workflowFiles);
  for (const [file, id] of metadataEntries) {
    if (!workflowSet.has(file)) {
      extra.push({ file, id });
    }
  }

  // Report results
  console.log(`Workflow files found: ${workflowFiles.length}`);
  console.log(`Metadata entries found: ${metadataEntries.size}\n`);

  if (missing.length > 0) {
    console.log('❌ Workflows MISSING from metadata:');
    for (const file of missing) {
      console.log(`   - ${file}`);
    }
    console.log('');
  }

  if (extra.length > 0) {
    console.log('⚠️  Metadata entries WITHOUT corresponding workflow file:');
    for (const { file, id } of extra) {
      console.log(`   - ${id} (references ${file})`);
    }
    console.log('');
  }

  if (missing.length === 0 && extra.length === 0) {
    console.log('✅ All workflows have metadata entries');
    console.log('✅ All metadata entries have corresponding workflows');
    process.exit(0);
  } else {
    console.log('─'.repeat(50));
    if (missing.length > 0) {
      console.log(`\nTo fix missing entries, add them to workflow-metadata.yaml`);
      console.log('following the existing pattern. Each entry needs:');
      console.log('  - file: the workflow filename');
      console.log('  - name: human-readable name');
      console.log('  - category: one of the defined categories');
      console.log('  - description: brief description (10-200 chars)');
      console.log('  - tags: language, trigger, complexity');
    }
    process.exit(1);
  }
}

main();

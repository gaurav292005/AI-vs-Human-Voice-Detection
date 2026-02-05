FROM node:20-alpine

# IMPORTANT: do NOT use /app as workdir
WORKDIR /workspace

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install pnpm and dependencies
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Debug (optional but helpful – safe to keep)
RUN ls -la && ls -la app

# Build the application
RUN pnpm run build

# Expose port
EXPOSE 3000

ENV NODE_ENV=production

# Start the application
CMD ["pnpm", "run", "start"]

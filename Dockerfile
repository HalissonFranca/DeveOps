# --- Estágio 1: Build ---
FROM maven:3.9.5-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .

# Build do projeto (sem rodar testes)
RUN mvn -B package -DskipTests

# --- Estágio 2: Runtime ---
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

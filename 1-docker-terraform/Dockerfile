FROM python:3.13-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin

WORKDIR /code
ENV PATH="/code/.venv/bin:$PATH"

COPY pyproject.toml .python-version uv.lock ./
RUN uv sync --locked

COPY green_tripdata_2025-11.parquet taxi_zone_lookup.csv ./
COPY ingestion.py .

ENTRYPOINT ["uv", "run", "python", "ingestion.py"]


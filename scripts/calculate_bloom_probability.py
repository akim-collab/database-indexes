import math

def calculate_collision_probability(m, k, n):
    """
    Вычисление вероятности коллизии в Bloom-фильтре.

    :param m: Размер массива бит (в битах)
    :param k: Количество хеш-функций
    :param n: Количество вставок
    :return: Вероятность коллизии
    """
    # Вероятность того, что ни одна хеш-функция не записала 1 в j-й бит
    prob_no_set = (1 - 1/m) ** (k * n)
    # Вероятность хотя бы одной коллизии
    prob_collision = 1 - prob_no_set
    return prob_collision

if __name__ == "__main__":
    m = 2**32      # Размер массива бит
    k = 32         # Количество хеш-функций
    n = 2_000_000  # Количество вставок

    probability = calculate_collision_probability(m, k, n)
    print(f"Вероятность коллизии (Bloom): {probability:.3f} или {probability * 100:.1f}%")
import pickle
import matplotlib.pyplot as plt
import numpy as np
import torch




def load_pickle(file_path):
    with open(file_path, 'rb') as handle:
        unserialized_data = pickle.load(handle)
    print(unserialized_data)
    return np.array(unserialized_data).flatten()

def draw_loss(loss_hist):
    plt.scatter(np.arange(len(loss_hist)), loss_hist)
    plt.xlabel("iteration")
    plt.ylabel("loss")
    plt.show()

def draw_score(score_hist):
    plt.scatter(np.arange(len(score_hist)), score_hist)
    plt.xlabel("episode")
    plt.ylabel("score")
    plt.show()



if __name__ == "__main__":
    # loss_hist = load_pickle('loss_hist/loss_history_500.pickle')
    # draw_loss(loss_hist)
    score_hist = load_pickle('score_hist/score_history_600.pickle')
    draw_score(score_hist)

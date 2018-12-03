import pickle
import matplotlib.pyplot as plt
import numpy as np
import torch
import argparse
import sys
import os

parser = argparse.ArgumentParser()
parser.add_argument('--dir', required=True, help="directory of folder")




def load_pickle(file_path):
    with open(file_path, 'rb') as handle:
        unserialized_data = pickle.load(handle)
    return np.array(unserialized_data).flatten()

def merge(np1, np2, file_name): # merge two numpy array
    print(np1.shape, np2.shape)
    file = np.concatenate((np1, np2))
    print(file.shape)
    with open(file_name, 'wb') as handle:
        pickle.dump(file, handle)


def draw_loss(dir):
    loss_hist = load_pickle(dir)

    plt.scatter(np.arange(len(loss_hist)), loss_hist)
    plt.xlabel("iteration")
    plt.ylabel("loss")
    plt.show()

def draw_score(dir):
    score_hist = load_pickle(dir)

    plt.scatter(np.arange(len(score_hist)), score_hist)
    plt.xlabel("episode")
    plt.ylabel("score")
    plt.show()

def draw_test_score(dir):
    test_score = load_pickle(dir)

    print(np.mean(test_score))

    plt.scatter(np.arange(len(test_score)), test_score)
    plt.xlabel("num of game")
    plt.ylabel("score")
    plt.show()


def main(argv):
    args = parser.parse_args(argv)
    ###### python3 history.py --dir FILE_DIRECTORY


    ###### merge two history ######
    # f1 = load_pickle(args.dir + 'loss_history_1.pickle')
    # f2 = load_pickle(args.dir + 'loss_history_2.pickle')
    # merge(f1, f2, args.dir + "loss_history.pickle")


    ###### draw history ######
    # draw_score(args.dir + "test_score_best_model.pickle")
    # draw_score(args.dir + "test_score_current_model_2000000.pickle")
    # draw_score(args.dir + "score_history.pickle")
    draw_loss(args.dir + "loss_history.pickle")
    # draw_test_score(args.dir + "test_score.pickle")


if __name__ == "__main__":
    main(sys.argv[1:])

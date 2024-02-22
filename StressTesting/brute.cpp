//!-----------------------------------------------------!//
//!                  YUSUF REZA HASNAT                  !//
//!-----------------------------------------------------!//

#pragma GCC optimize("O3")
#include <bits/stdc++.h>
#ifndef ONLINE_JUDGE
#include "C:\Users\Yusuf Reza Hasnat\OneDrive\Desktop\CP\debug.h"
#else
#define dbg(x...)
#define dbgc(x...)
#endif
using namespace std;

#define int long long
#define float long double
#define vf(v) (v).begin(), (v).end()
#define vr(v) (v).rbegin(), (v).rend()
#define endl "\n"
#define YUSUF ios_base::sync_with_stdio(false),
#define REZA cin.tie(NULL),
#define HASNAT cout.tie(NULL)

int mod = 1000000007;
int inf = 1e18;

void solve() {
    int n;
    cin >> n;
    vector<int> a(n);
    for (int i = 0; i < n; i++)
        cin >> a[i];
    int k = 0;
    for (k = 0; k <= n; k++) {
        int f = 1;
        multiset<int> s;
        for (int i = 0; i < n; i++)
            s.insert(a[i]);
        for (int i = 1; i <= k; i++) {
            if (s.size() == 0) {
                f = 0;
                break;
            }
            int round = k - i + 1;
            auto it = s.lower_bound(round);
            // dbg(k, *it, round);
            if (it == s.end()) {
                --it;
                s.erase(it);
            }
            else if (*it == round) {
                s.erase(it);
            }
            else {
                if (it == s.begin()) {
                    f = 0;
                    break;
                }
                it--;
                if (*it > round) {
                    f = 0;
                    break;
                }
                else {
                    s.erase(it);
                }
            }
            // s.erase(it);
            if (s.size()) {
                it = s.begin();
                int val = *it;
                s.erase(it);
                s.insert(val + round);
            }
            // dbg(s);
        }
        if (f == 0)
            break;
    }
    cout << k - 1 << endl;
}

int32_t main() {
    YUSUF REZA HASNAT;
    int t = 1;
    cin >> t;
    for (int i = 1; i <= t; i++) {
        solve();
    }
    return 0;
}
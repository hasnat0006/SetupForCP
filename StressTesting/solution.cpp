//!-----------------------------------------------------!//
//!                  YUSUF REZA HASNAT                  !//
//!-----------------------------------------------------!//

#pragma GCC optimize("O3")
#include <bits/stdc++.h>
using namespace std;

#define int long long
#define float long double
#define pb push_back
#define vf(v) (v).begin(), (v).end()
#define vr(v) (v).rbegin(), (v).rend()
#define dosomic(x) fixed << setprecision(x)
#define endl "\n"
#define case(x) cout << "Case " << x << ": "
#define YUSUF ios_base::sync_with_stdio(false),
#define REZA cin.tie(NULL),
#define HASNAT cout.tie(NULL)

int mod = 1000000007;
float pi = acos(-1);
int inf = 1e18;

void solve() {
    int n, k, x;
    cin >> n >> k;
    vector<int> v(n);
    for (int i = 0; i < n; i++) {
        cin >> x;
        v[i] = x;
    }
    int nn = n - k;
    int point1 = 0, point2 = 0, cnt = 0, ans = 0;
    for (int i = 1; i < n; i++) {
        int cur = v[i] * 1 << (cnt + 1);
        int prev = v[i - 1] * (1 << cnt);
        if (cur > prev)
            cnt++;
        else
            cnt = 0;
        if (cnt == k)
            ans++, cnt--;
    }
    cout << ans << endl;
}

int32_t main() {
    YUSUF REZA HASNAT;
    int t = 1;
    // cin >> t;
    for (int i = 1; i <= t; i++) {
        // case(i)
        solve();
    }
    return 0;
}